module ApplicationHelper
  # Stub for cloudflare-turnstile-rails gem (loaded via main app, not engine)
  unless method_defined?(:cloudflare_turnstile_tag)
    def cloudflare_turnstile_tag
      "".html_safe
    end
  end
end
