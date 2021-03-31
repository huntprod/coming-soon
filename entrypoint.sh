#!/bin/sh
set -u

export THE_PAGE_TITLE=${THE_PAGE_TITLE:-Coming Soon}
export THE_BACKGROUND_COLOR=${THE_BACKGROUND_COLOR:-black}
export THE_BACKGROUND_IMAGE=${THE_BACKGROUND_IMAGE:-default.jpg}
export THE_ACCENT_COLOR=${THE_ACCENT_COLOR:-grey}
export THE_BODY_TITLE=${THE_BODY_TITLE:-$THE_PAGE_TITLE}
export THE_INTRO_TEXT=${THE_INTRO_TEXT:-Stay Tuned.}
export THE_PLACEHOLDER=${THE_PLACEHOLDER:-you@your.domain}
export THE_THANKS=${THE_THANKS:-Thanks. We&apos;ll be in touch}

SHELL_FORMAT='$THE_PAGE_TITLE,$THE_BACKGROUND_COLOR,$THE_BACKGROUND_IMAGE,$THE_ACCENT_COLOR,$THE_BODY_TITLE,$THE_INTRO_TEXT,$THE_PLACEHOLDER'

for file in $(find /app/htdocs -type f -not -name '*.jpg'); do
  envsubst $SHELL_FORMAT < $file > /tmp/x
  mv /tmp/x $file
done

exec /app/coming-soon
