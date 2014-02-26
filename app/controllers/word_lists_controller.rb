class WordListsController < ApplicationController
  def index
    @tags = Parola.tag_counts
  end

  def show
    @tag = params[:tag]
    @parolas = Parola.tagged_with(params[:tag])
  end
end
