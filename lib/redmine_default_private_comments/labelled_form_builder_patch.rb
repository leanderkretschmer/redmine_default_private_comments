# lib/redmine_default_private_comments/labelled_form_builder_patch.rb
module RedmineDefaultPrivateComments
  module LabelledFormBuilderPatch
    def check_box(field, options = {}, checked_value = "1", unchecked_value = "0")
      if @object_name.to_s == "issue" && field.to_s == "private_notes"
        options = options.symbolize_keys
        issue = @template.instance_variable_get(:@issue) rescue nil
        if issue && issue.respond_to?(:private_notes_or_default)
          options[:checked] = issue.private_notes_or_default
        end
      end
      super(field, options.except(:label), checked_value, unchecked_value)
    end
  end
end
