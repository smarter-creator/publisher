require "ice_cube"

module RecurringSelectHelper
  module FormHelper
    def select_recurring(object, method, default_schedules = nil, options = {}, html_options = {})
      RecurringSelectTag.new(object, method, self, default_schedules, options, html_options).render
    end
  end
  
  module FormTagHelper
    def select_recurring_tag(name, default_schedules = nil, options = {}, html_options = {})
      RecurringSelectTag.new(nil, name, self, default_schedules, options, html_options).render
    end
  end

  module FormBuilder
    def select_recurring(method, default_schedules = nil, options = {}, html_options = {})
      if !@template.respond_to?(:select_recurring)
        @template.class.send(:include, RecurringSelectHelper::FormHelper)
      end

      @template.select_recurring(@object_name, method, default_schedules, options.merge(:object => @object), html_options)
    end
  end

  module FormOptionsHelper
    def recurring_options_for_select(currently_selected_rule = nil, default_schedules = nil, options = {})

      options_array = []
      blank_option_label = options[:blank_label] || I18n.t("recurring_select.not_recurring")
      blank_option = [blank_option_label, "null"]
      separator = [I18n.t("recurring_select.or"), {:disabled => true}]

      if default_schedules.blank?
        if currently_selected_rule.present?
          options_array << ice_cube_rule_to_option(currently_selected_rule)
          options_array << separator
          # options_array << [I18n.t("recurring_select.change_schedule"), "custom"]
          options_array << blank_option if options[:allow_blank]
        else
          options_array << blank_option
          # options_array << [I18n.t("recurring_select.set_schedule"), "custom"]
        end
      else
        options_array << blank_option if options[:allow_blank]

        options_array += default_schedules.collect{|dc|
          ice_cube_rule_to_option(dc)
        }

        if currently_selected_rule.present? and !current_rule_in_defaults?(currently_selected_rule, default_schedules)
          options_array << ice_cube_rule_to_option(currently_selected_rule, true)
          # custom_label = [I18n.t("recurring_select.new_custom_schedule"), "custom"]
        else
          # custom_label = [I18n.t("recurring_select.custom_schedule"), "custom"]
        end

        options_array << separator
        # options_array << custom_label
      end

      options_for_select(options_array, currently_selected_rule.to_json)
    end

    private

    def ice_cube_rule_to_option(supplied_rule, custom = false)
      return supplied_rule unless RecurringSelect.is_valid_rule?(supplied_rule)

      rule = RecurringSelect.dirty_hash_to_rule(supplied_rule)
      ar = [rule.to_s, rule.to_hash.to_json]

      # if custom
      #   ar[0] += "*"
      #   ar << {"data-custom" => true}
      # end

      ar
    end

    def current_rule_in_defaults?(currently_selected_rule, default_schedules)
      default_schedules.any?{|option|
        option == currently_selected_rule or
          (option.is_a?(Array) and option[1] == currently_selected_rule)
      }
    end
  end

  module SelectHTMLOptions
    private

    def recurring_select_html_options(html_options)
      html_options = html_options.stringify_keys
      html_options["class"] = (html_options["class"].to_s.split + ["recurring_select"]).join(" ")
      html_options
    end
  end

  class RecurringSelectTag < ActionView::Helpers::Tags::Select
    include RecurringSelectHelper::FormOptionsHelper
    include SelectHTMLOptions

    def initialize(object, method, template_object, default_schedules = nil, options = {}, html_options = {})
      @default_schedules = default_schedules
      html_options = recurring_select_html_options(html_options)

      super(object, method, template_object, @default_schedules, options, html_options)
    end

    def render
      option_tags = add_options(recurring_options_for_select(value, @default_schedules, @options), @options, value)
      select_content_tag(option_tags, @options, @html_options)
    end
  end
end
