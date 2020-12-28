class SearchController < ApplicationController
    def results
        if params[:termino].present?
            @users = User.buscador(params[:termino])
        else
            @users = User.where.not(id:1)
        end
    end
end