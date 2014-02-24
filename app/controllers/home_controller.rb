class HomeController < ApplicationController
  def index
    @parola = Parola.new    
    # search for word
    # if it exists, display result
    # otherwise convert entry and display that
    
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
