import pytest
from dotfiles.bb_parser import *


def test_exact_parser():
    assert Exact("a", key="1").parse("a".split(" ")) == {"1": "a"}
    with pytest.raises(ParseError):
        Exact("a", key="1").parse("b".split(" "))

    assert (Exact("a", key="1") + Exact("b", key="2")).parse("a b".split(" ")) == {"1": "a", "2": "b"}
    with pytest.raises(ParseError):
        (Exact("a", key="1") + Exact("b", key="2")).parse("a c".split(" "))


def test_converter_parser():
    assert String(key="1").parse("a".split(" ")) == {"1": "a"}
    assert (String(key="1") + String(key="2")).parse("a b".split(" ")) == {"1": "a", "2": "b"}

    assert Integer(key="1").parse("12".split(" ")) == {"1": 12}
    with pytest.raises(ParseError):
        Integer(key="1").parse("a".split(" "))


def test_flag_parser():
    assert Flag(Exact("a"), key="key").parse("a".split(" "))["key"]
    assert not Flag(Exact("a"), key="key").parse("b".split(" "))["key"]
    assert Flag(Exact("a") + Exact("b"), key="key").parse("a b".split(" "))["key"]
    with pytest.raises(ParseError):
        assert (Flag(Exact("a") + Exact("b"), key="key") + EndOfInput()).parse("a b c".split(" "))


def test_firstof_parser():
    assert FirstOf(Exact("a", key="k"), Exact("b", key="k")).parse("a".split(" "))["k"] == "a"
    assert FirstOf(Exact("a", key="k"), Exact("b", key="k")).parse("b".split(" "))["k"] == "b"

    with pytest.raises(ParseError):
        FirstOf(Exact("a", key="k"), Exact("b", key="k")).parse("c".split(" "))


def test_optional_parser():
    p = Optional(Exact("a", key="1")) + Exact("b", key="2")
    assert p.parse("b".split(" ")) == {"2": "b"}
    assert p.parse("a b".split(" ")) == {"1": "a", "2": "b"}

    p = Exact("a", key="1") + Optional(Exact("b", key="2")) + EndOfInput()
    assert p.parse("a".split(" ")) == {"1": "a"}
    assert p.parse("a b".split(" ")) == {"1": "a", "2": "b"}
    with pytest.raises(ParseError):
        p.parse("a c".split(" "))

    p = Exact("z", key="0") + Optional(Exact("a", key="1")) + Exact("b", key="2")
    assert p.parse("z a b".split(" ")) == {"0": "z", "1": "a", "2": "b"}
    assert p.parse("z b".split(" ")) == {"0": "z", "2": "b"}


def test_enum_parser():
    p = Enum("abcd", key="k")
    assert p.parse("a")["k"] == "a"
    assert p.parse("d")["k"] == "d"

    with pytest.raises(ParseError):
        p.parse("x")
