class Helpers
    def self.current_user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def self.build_error_msg(errors)
        err_msg = []
        errors.each do |key, value|
            err_msg << "#{key.to_s.gsub("_"," ").capitalize} #{value}\n"
        end
        err_msg
    end
end