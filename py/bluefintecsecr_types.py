# Typed models for the BluefinTecsEcr SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class EcrApiRequired(TypedDict):
    amount: str
    card_number: str
    currency: str
    terminal_number: str
    transaction_date_time: str
    transaction_id: str


class EcrApi(EcrApiRequired, total=False):
    authorization_number: str
    cvc2: str
    desired_currency: str
    ecr_data: str
    language: str
    message_type: str
    password: str
    payment_reason: str
    payment_reason_as_byte: list
    personal_id: str
    receipt_layout: str
    receipt_number: str
    transaction_origin_identifier: str
    transaction_origin_indicator: str
    transaction_place: str
    transaction_source_id: str


class EcrApiLoadMatch(TypedDict, total=False):
    amount: str
    authorization_number: str
    card_number: str
    currency: str
    cvc2: str
    desired_currency: str
    ecr_data: str
    language: str
    message_type: str
    password: str
    payment_reason: str
    payment_reason_as_byte: list
    personal_id: str
    receipt_layout: str
    receipt_number: str
    terminal_number: str
    transaction_date_time: str
    transaction_id: str
    transaction_origin_identifier: str
    transaction_origin_indicator: str
    transaction_place: str
    transaction_source_id: str


class EcrApiCreateDataRequired(TypedDict):
    amount: str
    card_number: str
    currency: str
    terminal_number: str
    transaction_date_time: str
    transaction_id: str


class EcrApiCreateData(EcrApiCreateDataRequired, total=False):
    authorization_number: str
    cvc2: str
    desired_currency: str
    ecr_data: str
    language: str
    message_type: str
    password: str
    payment_reason: str
    payment_reason_as_byte: list
    personal_id: str
    receipt_layout: str
    receipt_number: str
    transaction_origin_identifier: str
    transaction_origin_indicator: str
    transaction_place: str
    transaction_source_id: str
