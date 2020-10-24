module PermissionsConcern
    extend ActiveSupport::Concern

    def is_new_user?
        self.permission_level === 1
    end

    def is_normal_user?
        self.name != nil
        self.last_name != nil
        self.document != nil
        self.gender != nil
        self.phone != nil
        self.day != nil
        self.month != nil
        self.year != nil
        self.country != nil
        self.state != nil
        self.city != nil
        self.address != nil
    end

    def is_admin?
        self.permission_level >= 3
    end

end