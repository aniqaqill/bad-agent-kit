// Catalog validator — docs/catalog.md table ↔ manifest/upstream-sources.txt
// lockstep, provider parse + optionality + Go-fence assertion.
// Run: node scripts/validate-catalog.js
const fs = require('fs');
const path = require('path');

const root = path.join(__dirname, '..');
const catalog = fs.readFileSync(path.join(root, 'docs', 'catalog.md'), 'utf8');
const manifest = fs.readFileSync(path.join(root, 'manifest', 'upstream-sources.txt'), 'utf8');
const providersToml = fs.readFileSync(path.join(root, 'manifest', 'providers.toml'), 'utf8');

// Extract skill rows from the catalog table: | `name` | source | ... |
const rows = [...catalog.matchAll(/^\|\s*`([a-z0-9-]+)`\s*\|/gm)].map((m) => m[1]);

// Parse provider-grouped manifest rows: provider | source | path | channel | roles | opt | checked
const manifestLines = manifest
  .split('\n')
  .map((l) => l.trim())
  .filter((l) => l && !l.startsWith('#'));

const localSkills = manifestLines
  .filter((l) => l.startsWith('local:'))
  .map((l) => l.split(/\s*\|\s*/)[0].replace('local:', ''));
const upstreamSkills = manifestLines
  .filter((l) => !l.startsWith('local:'))
  .map((l) => {
    const [provider, , skillPath, , , opt] = l.split(/\s*\|\s*/).map((s) => (s || '').trim());
    return { provider, skill: skillPath.split('/').pop(), optional: opt === 'optional' };
  });

// Lockstep: every upstream pin must appear in the catalog table.
const missing = upstreamSkills.filter((e) => !rows.includes(e.skill));
// Stale: catalog rows that are neither upstream pins nor BAK-owned skills.
const stale = rows.filter((r) => !upstreamSkills.some((e) => e.skill === r) && !localSkills.includes(r));

// Optional providers absent from the catalog are info, not drift — but their
// pins must still be declared in providers.toml.
const optionalIds = upstreamSkills.filter((e) => e.optional).map((e) => e.provider);
const tomlProviders = providersToml
  .split('\n')
  .map((l) => l.trim())
  .filter((l) => l && !l.startsWith('#'))
  .map((l) => l.split(/\s+/)[0]);
const unpinnedOptional = [...new Set(optionalIds)].filter((id) => !tomlProviders.includes(id));

// Go fence: the go-* skills must be BAK-owned (local:) and never mapped to a provider role.
const goSkills = ['go-plan', 'go-tdd', 'go-review'];
const fenceViolation = upstreamSkills.filter((e) => goSkills.includes(e.skill));
const missingLocal = goSkills.filter((s) => !localSkills.includes(s));

let failed = false;
if (missing.length) {
  console.error('Catalog drift: upstream pins missing from docs/catalog.md:', missing.map((e) => e.skill).join(', '));
  failed = true;
}
if (stale.length) {
  console.error('Catalog drift: docs/catalog.md rows not in manifest or owned:', stale.join(', '));
  failed = true;
}
if (unpinnedOptional.length) {
  console.error('Optional providers not declared in providers.toml:', unpinnedOptional.join(', '));
  failed = true;
}
if (fenceViolation.length) {
  console.error('GO FENCE VIOLATION: go-* skills must be local:, never a provider role:', fenceViolation.map((e) => e.skill).join(', '));
  failed = true;
}
if (missingLocal.length) {
  console.error('GO FENCE VIOLATION: missing local: declaration for', missingLocal.join(', '));
  failed = true;
}

if (failed) process.exit(1);
console.log(
  `Catalog lockstep OK: ${rows.length} catalog rows, ${upstreamSkills.length} provider pins, ` +
  `${localSkills.length} BAK-owned skills. Go fence intact.`
);
