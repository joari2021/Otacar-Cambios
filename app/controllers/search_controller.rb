class SearchController < ApplicationController
    def results
        if params[:termino].present?
            @users = User.buscador(params[:termino])
        else
            @users = User.all
        end
    end
end