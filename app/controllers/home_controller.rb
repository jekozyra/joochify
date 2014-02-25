class HomeController < ApplicationController
  
  layout 'home'
  
  def index
    @parola = Parola.new
  end
  
  
  def parola_search
    @parola = nil
    if Parola.exists?(input: params["parola"]["input"])
      @parola = Parola.where(input: params["parola"]["input"]).first
    else
      @parola = Parola.create(input: params["parola"]["input"])
    end
        
    respond_to do |format|
      format.js
    end    
  end
  
  
end
