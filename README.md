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

## Videos
The two videos from Wix are in `videos/` (720p, about 7 MB each), with a cover picture for each
that shows before someone presses play:
- `community-hub-video.mp4` — home page
- `rugby-club-video.mp4` — rugby page

To swap one, replace the `.mp4` (and its `-poster.jpg`) with a new file of the same name.
Keep videos under about 50 MB; GitHub won't accept single files over 100 MB.

## Still to do before going live
1. ~~**Videos**~~ — done, see above.
2. ~~**Forms**~~ — done. Connected to Web3Forms (free, 250 messages/month), which emails
   higginshawcp@outlook.com. Contact messages arrive as "Website message: <their subject>";
   newsletter signups as "New newsletter signup: <their email>" (hit Reply to answer them).
   The access key (set 28 Oct 2026) is in each page's footer forms (`name="access_key"`).
   To change it, find-and-replace the old key across all `.html` files. The sending code
   is in `js/main.js`. Works on any host, including your own domain later.
3. ~~**Domain**~~ — done: www.higginshawcommunityproject.uk (canonical and share-image tags
   on every page use it).
4. **Colours** — top of `css/style.css`; swap `--brand` / `--accent` for the club colours.
5. Zumba times still say "(Post to be updated for timings)" — that's from the original.

## Live site
Address: https://www.higginshawcommunityproject.uk/
(the old https://deakz95.github.io/higginshaw-site/ link now forwards there)
Files: https://github.com/Deakz95/higginshaw-site (public)

How it's wired:
- **Hosting:** GitHub Pages serves the files in this folder. The `CNAME` file tells it
  the address is www.higginshawcommunityproject.uk; don't delete it.
- **Domain:** registered at Cloudflare (renews Oct 2031). In Cloudflare DNS, `www` and the
  bare domain (`@`) are CNAME records pointing to `deakz95.github.io`, set to **DNS only**
  (grey cloud). Leave them grey: GitHub provides the https certificate.

After editing anything, upload the changes and the live site updates within a minute or two:

    git add -A
    git commit -m "Describe what you changed"
    git push
