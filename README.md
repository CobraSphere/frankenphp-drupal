# Drupal on FrankenPHP

Run the popular [Drupal CMS](https://drupal.org) on top of [FrankenPHP](https://frankenphp.dev),
the modern app server for PHP.

## Getting Started

### Fork (this repo) instructions
```
git clone https://github.com/CobraSphere/frankenphp-drupal
cd frankenphp-drupal
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

