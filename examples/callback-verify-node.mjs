import crypto from "node:crypto";

export function verifyHumanEndpointCallback(rawBody, signatureHeader, signingSecret) {
  const expected =
    "sha256=" +
    crypto.createHmac("sha256", signingSecret).update(rawBody).digest("hex");

  const expectedBuffer = Buffer.from(expected, "utf8");
  const actualBuffer = Buffer.from(signatureHeader ?? "", "utf8");

  return (
    expectedBuffer.length === actualBuffer.length &&
    crypto.timingSafeEqual(expectedBuffer, actualBuffer)
  );
}
