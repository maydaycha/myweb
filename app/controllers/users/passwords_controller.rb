class Users::PasswordsController < Devise::PasswordsController

    def edit
        puts params.to_json
        puts session.to_json
        super
    end
end
