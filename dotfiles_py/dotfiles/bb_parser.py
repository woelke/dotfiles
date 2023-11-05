#!/usr/bin/python
from pathlib import Path


class ParseError(Exception):
    pass


class EndOfInput:
    def _run(self, argv):
        if len(argv) > 0:
            raise ParseError(f"Expected no more arguments but received: {' '.join(argv)}")
        return [], {}


class ParserBase:
    def __init__(self):
        self._next = None

    def _run(self, argv):
        argv_new, parsed_args = self._parse(argv)
        if self._next is None:
            return argv_new, parsed_args
        argv_new, parsed_args_new = self._next._run(argv_new)
        return argv_new, parsed_args | parsed_args_new

    def _parse(self, argv):
        raise ParseError("_parse() not implemented")

    def parse(self, argv):
        return self._run(argv)[1]

    def __add__(self, next):
        last = self
        while last._next is not None:
            last = last._next
        last._next = next
        return self


class Optional(ParserBase):
    def __init__(self, parser):
        super().__init__()
        self._parser = parser

    def _parse(self, argv):
        try:
            return self._parser._run(argv)
        except ParseError:
            return argv, {}


class FirstOf(ParserBase):
    def __init__(self, *parsers):
        super().__init__()
        self._parsers = parsers

    def _parse(self, argv):
        for parser in self._parsers:
            try:
                return parser._run(argv)
            except ParseError:
                pass
        raise ParseError("None of the parsers were suitable")


class Exact(ParserBase):
    def __init__(self, expected, key=None, value=None):
        super().__init__()
        self._expected = expected
        self._key = key
        self._value = value

    def _parse(self, argv):
        if len(argv) == 0:
            raise ParseError("Missing argument")
        if self._expected != argv[0]:
            raise ParseError(f"value {self._expected} expected but got {argv[0]}")
        return argv[1:], {self._key: self._expected if self._value is None else self._value} if self._key is not None else {}


class Enum(ParserBase):
    def __init__(self, allowed_values, key=None, values=None):
        super().__init__()
        self._allowed_values = allowed_values
        self._key = key
        self._values = values

    def _parse(self, argv):
        if len(argv) == 0:
            raise ParseError("Missing argument")

        if argv[0] not in self._allowed_values:
            raise ParseError(f"on of [{', '.join(self._allowed_values)}] expected bug got {argv[0]}")

        value = self._values[self._allowed_values.index(argv[0])] if self._values is not None else argv[0]
        return argv[1:], {self._key: value} if self._key is not None else {}


class Converter(ParserBase):
    def __init__(self, convert_to, key=None):
        super().__init__()
        self._convert_to = convert_to
        self._key = key

    def _parse(self, argv):
        if len(argv) == 0:
            raise ParseError("Missing argument")
        value = self._convert_to(argv[0])
        return argv[1:], {self._key: value} if self._key is not None else {}


class String(Converter):
    def __init__(self, key=None):
        super().__init__((lambda x: x), key)


class Integer(Converter):
    def __init__(self, key=None):
        def to_int(x):
            try:
                return int(x)
            except ValueError:
                raise ParseError(f"int expected but got {x}")
        super().__init__(to_int, key)


class ExistingPath(Converter):
    def __init__(self, key=None):
        def to_path(x):
            path = Path(x)
            if not path.exists():
                raise ParseError(f"path {path} does not exist")
            return path.absolute()
        super().__init__(to_path, key)


class Flag(ParserBase):
    def __init__(self, parser, key=None):
        super().__init__()
        self._parser = parser
        self._key = key

    def _parse(self, argv):
        try:
            argv_new, _ = self._parser._run(argv)
            return argv_new, {self._key: True} if self._key is not None else {}
        except ParseError:
            return argv, {self._key: False} if self._key is not None else {}
