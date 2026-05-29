"""Unit tests."""

from cmd_fixtures import CG_OUT_1, CG_OUT_2

from ckp.core import ConsumerGroupState
from ckp.utils import parse_consumer_groups_output


def test_parse():
    """Test the CLI output parser functionality."""
    parsed = parse_consumer_groups_output(CG_OUT_1)
    assert len(parsed) == 6
    assert {state.group for state in parsed} == {"cg1", "cg2"}
    for item in parsed:
        for attr in ("current_offset", "log_end_offset", "lag"):
            val = getattr(item, attr)
            assert isinstance(val, int)
    assert (
        ConsumerGroupState("cg1", "t1", 1, current_offset=100, log_end_offset=329, lag=229)
        in parsed
    )
    parsed = parse_consumer_groups_output(CG_OUT_2)
    assert len(parsed) == 9
    assert {state.group for state in parsed} == {"cg1", "cg2", "long-john-silver"}
