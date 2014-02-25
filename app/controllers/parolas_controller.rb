class ParolasController < ApplicationController
  before_action :set_parola, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, except: [:new, :create]



  # GET /parolas
  # GET /parolas.json
  def index
    @parolas = Parola.all
  end

  # GET /parolas/1
  # GET /parolas/1.json
  def show
  end

  # GET /parolas/new
  def new
    @parola = Parola.new
  end

  # GET /parolas/1/edit
  def edit
  end

  # POST /parolas
  # POST /parolas.json
  def create
    @parola = Parola.new(parola_params)

    respond_to do |format|
      if @parola.save
        format.html { redirect_to @parola, notice: 'Parola was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parola }
      else
        format.html { render action: 'new' }
        format.json { render json: @parola.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parolas/1
  # PATCH/PUT /parolas/1.json
  def update
    respond_to do |format|
      if @parola.update(parola_params)
        format.html { redirect_to parolas_url, notice: 'Parola was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parola.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parolas/1
  # DELETE /parolas/1.json
  def destroy
    @parola.destroy
    respond_to do |format|
      format.html { redirect_to parolas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parola
      @parola = Parola.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parola_params
      params.require(:parola).permit(:input, :output, :definition, :part_of_speech, :etymology_language)
    end
end
