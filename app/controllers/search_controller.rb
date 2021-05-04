class SearchController < ApplicationController
    before_action :authenticate_admin!
    def results
        limit_items_for_page = 20
        if params[:termino].present?
            @users = User.where.not(id:1).buscador(params[:termino])
                         .paginate(page: params[:page],per_page:limit_items_for_page)
        else
            @users = User.where.not(id:1)
                         .paginate(page: params[:page],per_page:limit_items_for_page)
        end
    end
end