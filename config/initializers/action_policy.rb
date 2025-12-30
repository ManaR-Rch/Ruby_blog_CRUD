# frozen_string_literal: true

require_relative '../../app/policies/application_policy'

ActionPolicy::Base.default_policy = ApplicationPolicy

  # Use the method `policy` to find a policy class
  # config.policy_name_cache_enabled = true

  # Restrict to whitelisted failure reasons (you can only check them in `check_result`)
  # config.strict_mode_enabled = true

  # Save rule names in result objects (required for `pundit_dry_run`)
  # config.dry_run_enabled = true

  # Notify all subscribers about authorize calls
  # config.notify = true

