class SearchController < ApplicationController
    before_action :authenticate_admin!
    def results
        limit_items_for_page = 20
        if params[:termino].present?
            @users = User.paginate(page: params[:page],per_page:limit_items_for_page).where.not(id:1).buscador(params[:termino])
        else
            @users = User.paginate(page: params[:page],per_page:limit_items_for_page).where.not(id:1)
        end
    end
end