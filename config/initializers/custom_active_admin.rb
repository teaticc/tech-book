module ActiveAdmin
  module Views
    class Header < Component

      def build(namespace, menu)
        super(id: "header")

        @namespace = namespace
        @menu = menu
        @utility_menu = @namespace.fetch_menu(:utility_navigation)

        build_site_title
        # build_global_navigation
        # build_utility_navigation
      end


      def build_site_title
        # insert_tag view_factory.site_title, @namespace
        render "admin/header"
      end

    end
  end
end