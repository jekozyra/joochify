class HomeController < ApplicationController
  
  layout 'home'
  
  def index
    @parola = Parola.new
  end
  
  
  def parola_search
    
    @parola = nil
    @parola = PgSearch.multisearch(params["parola"]["input"]).shuffle.map(&:searchable).first
    unless @parola
      @parola = Parola.create(input: params["parola"]["input"])
    end
        
    respond_to do |format|
      format.js
    end    
  end
  
  def about
  end
  
  
end
