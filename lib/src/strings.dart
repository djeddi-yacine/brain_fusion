import 'dart:convert';

final origin = utf8.decode(base64.decode('aHR0cHM6Ly9mdXNpb25icmFpbi5haQ=='));
final referer = '$origin/en/diffusion';
final api = '$origin/api/v1/text2image';
final checkQueueAPI = '$api/inpainting/checkQueue';
final runAPI = '$api/run';
final pocketsAPI = '$api/generate/pockets';
const userAgent =
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36';
const secChUa =
    '"Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"';
