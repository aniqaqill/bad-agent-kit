// Catalog validator — README table ↔ manifest/upstream-sources.txt lockstep.
// Run: node scripts/validate-catalog.js
const fs = require('fs');
const path = require('path');

const root = path.join(__dirname, '..');
const readme = fs.readFileSync(path.join(root, 'README.md'), 'utf8');
const manifest = fs.readFileSync(path.join(root, 'manifest', 'upstream-sources.txt'), 'utf8');

// Extract skill rows from the README table: | `name` | source | ... |
const rows = [...readme.matchAll(/^\|\s*`([a-z0-9-]+)`\s*\|/gm)].map((m) => m[1]);
const manifestSkills = manifest
  .split('\n')
  .filter((l) => l && !l.startsWith('#') && !l.startsWith('//') && !l.startsWith('local:'))
  .map((l) => l.trim().split(/\s+/).filter(Boolean).pop())
  .map((p) => p.replace('skills/', '').split('/').pop());

const missing = manifestSkills.filter((s) => s !== 'bak' && !rows.includes(s));
const stale = rows.filter((s) => !manifestSkills.includes(s) && s !== 'bak' && s !== 'chief');

if (missing.length || stale.length) {
  console.error('Catalog drift detected:');
  if (missing.length) console.error('  in manifest but missing from README:', missing.join(', '));
  if (stale.length) console.error('  in README but not in manifest:', stale.join(', '));
  process.exit(1);
}
console.log(`Catalog lockstep OK: ${rows.length} rows, ${manifestSkills.length} manifest entries.`);
