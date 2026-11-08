# GitHub Publishing Contract

- Draft locally unless the user explicitly authorizes publishing, pushing,
  merging, creating an issue/PR, commenting, or changing remote state.
- Use `gh` for GitHub Issues; SSH proves git transport, not GitHub API access.
- For explicit access, authentication, reachability, permissions, PR, issue, or
  Actions checks, run the relevant `gh` or git network command outside the
  default sandbox. Start with `gh auth status`.
- If the token is invalid, ask the user to run `gh auth login -h github.com`.
- If DNS or API access fails despite working local credentials, retry the
  specific command outside the sandbox. If it still fails, report the failure
  and suggest checking VPN/proxy DNS.
- For pushes, use the existing working remote/auth transport; do not force SSH
  or HTTPS.

## Parent and child issues

When publishing an epic/PRD with implementation tickets, create real GitHub
sub-issue relationships rather than relying only on Markdown links:

1. Create the parent and child issues with `gh issue create`.
2. Resolve their node IDs:

   ```bash
   gh api graphql -f owner=OWNER -f name=REPO -F parent=PARENT_NUMBER -F child=CHILD_NUMBER -f query='query($owner:String!, $name:String!, $parent:Int!, $child:Int!) { repository(owner:$owner, name:$name) { parent: issue(number:$parent) { id url } child: issue(number:$child) { id url } } }'
   ```

3. Attach each child:

   ```bash
   gh api graphql -f parentId=PARENT_NODE_ID -f childId=CHILD_NODE_ID -f query='mutation($parentId:ID!, $childId:ID!) { addSubIssue(input:{issueId:$parentId, subIssueId:$childId}) { issue { id } subIssue { id } } }'
   ```

Create in dependency order and attach every implementation issue to the parent.
