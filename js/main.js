// Mobile menu toggle + current year in footer
document.addEventListener('DOMContentLoaded', () => {
  const toggle = document.querySelector('.nav-toggle');
  const nav = document.querySelector('.nav');
  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      const open = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', open);
    });
    nav.querySelectorAll('a').forEach(a => a.addEventListener('click', () => nav.classList.remove('open')));
  }
  document.querySelectorAll('[data-year]').forEach(el => (el.textContent = new Date().getFullYear()));

  // Contact + newsletter forms: send through Web3Forms (emails the club inbox)
  // and show a thank-you message on the page instead of leaving the site.
  const CLUB_EMAIL = 'higginshawcp@outlook.com';
  const emailLink = `<a href="mailto:${CLUB_EMAIL}">${CLUB_EMAIL}</a>`;

  document.querySelectorAll('form.site-form').forEach(form => {
    const status = document.createElement('p');
    status.className = 'form-status';
    status.setAttribute('role', 'status');
    status.setAttribute('aria-live', 'polite');
    form.after(status);
    const show = (type, html) => { status.className = `form-status ${type}`; status.innerHTML = html; };

    form.addEventListener('submit', async event => {
      event.preventDefault();
      if (form.elements.access_key.value.startsWith('YOUR_')) {
        show('error', `This form isn&rsquo;t connected yet. Please email us at ${emailLink}.`);
        return;
      }
      const data = Object.fromEntries(new FormData(form));
      // Put the visitor's subject (or the new subscriber's email) in the email's subject line
      const field = form.dataset.subjectField;
      if (field && data[field]) data.subject = form.dataset.subjectPrefix + data[field];

      const button = form.querySelector('[type="submit"]');
      const label = button.textContent;
      button.disabled = true;
      button.textContent = 'Sending…';
      status.className = 'form-status';
      status.textContent = '';
      try {
        const res = await fetch(form.action, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
          body: JSON.stringify(data),
        });
        const result = await res.json().catch(() => ({}));
        if (!res.ok || !result.success) throw new Error(result.message || `HTTP ${res.status}`);
        form.reset();
        form.hidden = true;
        show('success', form.dataset.success);
      } catch (err) {
        console.error('Form send failed:', err);
        show('error', `Sorry, that didn&rsquo;t send. Please try again, or email us at ${emailLink}.`);
      } finally {
        button.disabled = false;
        button.textContent = label;
      }
    });
  });
});
