module LocaleConfigs
  extend ActiveSupport::Concern

  included do
    private

    def find_out_locale
      header = request.env['HTTP_ACCEPT_LANGUAGE']

      q_factors = header.split(',').map do |lan|
        pair = lan.split(';')
        next if pair[1].blank?

        [pair[0], pair[1].tr('q=', '').to_f]
      end.compact

      return if q_factors.blank?

      q_factors.to_h.sort_by {|_, v| -v}.each do |lan, _|
        return lan if I18n.available_locales.include?(lan)
      end

      nil
    end
  end
end