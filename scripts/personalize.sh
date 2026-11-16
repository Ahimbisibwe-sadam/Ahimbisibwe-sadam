#!/usr/bin/env bash
# Personalize the neon profile kit.
# Usage: ./scripts/personalize.sh <github-username> ["Display Name"] [email]
set -euo pipefail
cd "$(dirname "$0")/.."

NEW_USER="${1:?usage: personalize.sh <github-username> [display-name] [email]}"
NEW_NAME="${2:-sadam}"
NEW_EMAIL="${3:-sada63257@gmail.com}"

OLD_USER=sadam
OLD_EMAIL=sada63257@gmail.com
OLD_UPPER="AHIMBISIBWE SADAM"
OLD_LOWER="ahimbisibwe sadam"
NEW_UPPER="${NEW_NAME^^}"
NEW_LOWER="${NEW_NAME,,}"

echo "→ username:  $OLD_USER   → $NEW_USER"
echo "→ name:      $OLD_UPPER  → $NEW_UPPER"
echo "→ email:     $OLD_EMAIL  → $NEW_EMAIL"

# The display name contains the username, so protect full-name and email
# phrases with sentinels first, then replace the username freely.
sed -i \
  -e "s|$OLD_LOWER|@@NAME@@|g" \
  -e "s|$OLD_UPPER|@@UPPER@@|g" \
  -e "s|$OLD_EMAIL|@@EMAIL@@|g" \
  README.md SETUP.md
sed -i "s|$OLD_UPPER|@@UPPER@@|g" assets/banner.svg

sed -i "s|$OLD_USER|$NEW_USER|g" README.md SETUP.md assets/banner.svg .github/workflows/snake.yml

sed -i \
  -e "s|@@NAME@@|$NEW_LOWER|g" \
  -e "s|@@UPPER@@|$NEW_UPPER|g" \
  -e "s|@@EMAIL@@|$NEW_EMAIL|g" \
  README.md SETUP.md
sed -i "s|@@UPPER@@|$NEW_UPPER|g" assets/banner.svg

echo "✔ done — preview at https://github.com/$NEW_USER (after push)"
echo "  reminder: enable Actions write permissions + run the 🐍 workflow once."
