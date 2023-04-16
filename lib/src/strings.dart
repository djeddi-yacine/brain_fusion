import 'dart:convert';

final origin = utf8.decode(base64.decode('aHR0cHM6Ly9mdXNpb25icmFpbi5haQ=='));
final referer = '$origin/en/diffusion';
final api = '$origin/api/v1/text2image';
final checkQueueAPI = '$api/inpainting/checkQueue';
final runAPI = '$api/run';
final pocketsAPI = '$api/generate/pockets';
