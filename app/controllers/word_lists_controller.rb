class WordListsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag = params[:tag]
    @parolas = Parola.tagged_with(params[:tag])
  end
end
