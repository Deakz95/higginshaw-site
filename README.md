# Higginshaw Community Project — local rebuild

Static rebuild of https://zoephillipahamilton.wixsite.com/higginshaw-community
(scraped 28 Oct 2026). Plain HTML + one CSS file + a tiny JS file — no build step,
works on any host.

## Images
All images now live in `images/` (done 28 Oct 2026 by `download-images.ps1`), and every page
points at those local copies, so the site no longer depends on Wix.

Files are named by what they show, starting with the part of the site they belong to
(`history-`, `press-`, `venue-`, `rugby-`, `kit-shop-`, `activities-`). There are 58 files from
37 photos, because some photos are kept at more than one size, e.g. a thumbnail and the
full-size "click to enlarge" version. Those have their width in pixels at the end:
`kit-shop-mug-800.jpg` is the thumbnail, `kit-shop-mug-2000.jpg` the big one.

To swap a photo, overwrite the file with a new one of the same name and roughly the same shape.
Don't run `download-images.ps1` again: the images are already local, so it has nothing to do.

## Pages
| File | Was on Wix |
|---|---|
| `index.html` | `/` (home) |
| `news.html` | `/latest-news` |
| `news/welcome.html` | `/post/support-small-businesses-by-shopping-locally` |
| `news/history-of-higginshaw-arlfc.html` | `/post/recycling-best-practices` |
| `news/in-the-press.html` | `/post/how-to-help-vulnerable-communities` |
| `activities.html` | `/activities-groups` |
| `rugby.html` | `/rugby-fixtures` |

The old blog URLs were leftover Wix template names, so they've been given proper slugs.

### Not rebuilt (on purpose)
- `/volunteers`, `/gallery-1`, `/dumping-page` — hidden pages that only contain
  unedited Wix template placeholder text (San Francisco address, fake phone number, etc.).
  Nothing real to carry over. The home page mentions volunteering, so a proper
  Volunteers page is worth writing.
- `/members` — Wix members-area login, which doesn't exist outside Wix.

## Still to do before going live
1. **Videos** — the home and rugby pages each had an embedded video that the scrape
   couldn't capture. Search for `TODO: paste the YouTube embed` and drop in the embed code.
2. **Forms** — the contact and newsletter forms were Wix-powered. They're marked up ready
   for Netlify Forms (`data-netlify="true"`); on other hosts point them at Formspree or
   similar. Search for `TODO`.
3. **Domain** — replace `https://www.example.com/` in the canonical tags with your domain.
   Also make the `og:image` tags full addresses (e.g. `https://yourdomain/images/...`);
   Facebook and WhatsApp link previews ignore relative paths like `images/...`.
4. **Colours** — top of `css/style.css`; swap `--brand` / `--accent` for the club colours.
5. Zumba times still say "(Post to be updated for timings)" — that's from the original.

## Preview link (GitHub Pages)
Live preview: https://deakz95.github.io/higginshaw-site/
Files: https://github.com/Deakz95/higginshaw-site (public)

After editing anything, upload the changes and the preview updates within a minute or two:

    git add -A
    git commit -m "Describe what you changed"
    git push

## Deploying to your own domain
Upload the whole folder to any static host (Netlify, Cloudflare Pages, GitHub Pages, or
your web host's `public_html`). On Netlify/Cloudflare you can just drag the folder in.
GitHub Pages can also use your own domain: repo Settings > Pages > Custom domain.
