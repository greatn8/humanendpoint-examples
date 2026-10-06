import hashlib
import hmac


def verify_humanendpoint_callback(
    raw_body: bytes,
    signature_header: str,
    signing_secret: str,
) -> bool:
    digest = hmac.new(
        signing_secret.encode("utf-8"),
        raw_body,
        hashlib.sha256,
    ).hexdigest()

    expected = f"sha256={digest}"
    return hmac.compare_digest(expected, signature_header or "")
