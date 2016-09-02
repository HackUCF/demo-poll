class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  def reset
    @poll = Poll.find(params[:pid])
    @poll.options.each do |o|
      o.votes.destroy_all
    end

    redirect_to "/polls/#{@poll.id}"
  end

  def delete_options
    @poll = Poll.find(params[:pid])
    @poll.options.destroy_all

    redirect_to "/polls/#{@poll.id}"
  end

  # GET /polls/1/vote/1
  def vote
    pid = params[:pid]
    oid = params[:option]

    @poll = Poll.find(pid)

    option = Option.find(oid)
    option.votes << Vote.new(ip: "placeholder", created_at: (Time.now.to_f.round(3)*1000).to_i)
  end

  def vote_fake
    pid = params[:pid]
    @poll = Poll.find(pid)
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    poll = Poll.find(params[:id])
    title = params[:title]

    poll.options << Option.create(title: title)

    flash[:notice] = "Option added."

    redirect_to "/polls/#{poll.id}/edit"
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:title, :description)
    end
end
