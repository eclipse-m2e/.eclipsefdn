local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.m2e', 'eclipse-m2e') {
  settings+: {
    blog: "https://www.eclipse.org/m2e/",
    description: "M2Eclipse provides tight integration for Apache Maven into the Eclipse IDE",
    email: "m2e-dev@eclipse.org",
    name: "Eclipse m2e project",
    web_commit_signoff_required: false,
    workflows+: {
      default_workflow_permissions: "write",
    },
  },
  secrets+: [
    orgs.newOrgSecret('M2E_GITLAB_API_TOKEN') {
      value: "pass:bots/technology.m2e/gitlab.eclipse.org/api-token",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('eclipse-m2e.github.io') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "master",
      gh_pages_source_path: "/",
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "master"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('m2e-core') {
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      has_discussions: true,
      squash_merge_commit_title: "PR_TITLE",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/m2e/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
      ],
    },
    orgs.newRepo('m2e-discovery-catalog') {
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      gh_pages_build_type: "workflow",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/m2e/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "master"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('m2e-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
    orgs.newRepo('m2e-wtp') {
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
    orgs.newRepo('m2e-wtp-jpa') {
      allow_merge_commit: true,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
    orgs.newRepo('org.eclipse.m2e.workspace') {
      allow_merge_commit: true,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      has_issues: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/m2e/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
      ],
    },
    orgs.newRepo('m2e-core-tests') {
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      description: "Test suite for m2e",
      forked_repository: "tesla/m2e-core-tests",
      fork_default_branch_only: true,
      has_wiki: false,
      homepage: "www.eclipse.org/m2e",
      workflows+: {
        enabled: false,
      },
    },
  ],
}
