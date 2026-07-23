# BluefinTecsEcr SDK utility: make_context

from core.context import BluefinTecsEcrContext


def make_context_util(ctxmap, basectx):
    return BluefinTecsEcrContext(ctxmap, basectx)
