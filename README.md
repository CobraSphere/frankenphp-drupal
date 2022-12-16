# Drupal on FrankenPHP

Run the popular [Drupal CMS](https://drupal.org) on top of [FrankenPHP](https://frankenphp.dev),
the modern app server for PHP.

Based on the original created by Kévin Dunglas: https://github.com/dunglas/frankenphp-drupal

## Getting Started

### Fork (this repo) instructions
```
git clone https://github.com/CobraSphere/frankenphp-drupal
cd frankenphp-drupal
cp .env.example .env # and adapt as needed
docker compose pull --include-deps
docker compose up
```

### Original instructions

```
git clone https://github.com/dunglas/frankenphp-drupal
cd frankenphp-drupal
docker compose pull --include-deps
docker compose up
```

Drupal will be installed during container startup with `admin` for the username and password.

