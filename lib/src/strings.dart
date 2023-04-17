import 'dart:convert';

///Create [origin] final
final origin = utf8.decode(base64.decode('aHR0cHM6Ly9mdXNpb25icmFpbi5haQ=='));

///Create [referer] final
final referer = '$origin/en/diffusion';

///Create [api] final
final api = '$origin/api/v1/text2image';

///Create [checkQueueAPI] final
final checkQueueAPI = '$api/inpainting/checkQueue';

///Create [runAPI] final
final runAPI = '$api/run';

///Create [pocketsAPI] final
final pocketsAPI = '$api/generate/pockets';

///Create [userAgent] final
const userAgent =
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36';

///Create [secChUa] final
const secChUa =
    '"Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"';
