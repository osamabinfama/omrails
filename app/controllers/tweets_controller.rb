class TweetsController < ApplicationController
  # before_action :authenticate_user!, only: [:index, :show]
  
  # GET /tweets
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  def show
    @tweet = Tweet.find(params[:id])
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.new
  end

  # GET /tweets/1/edit
  def edit
     @tweet = current_user.tweets.find(params[:id])
  end

  # POST /tweets
  def create
    @tweet = current_user.tweets.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
                    format.html { render :new }
                    format.json { render json: @tweet.errors, status: :unprocessable_entity }
                    end
                    end
  end

  # PATCH/PUT /tweets/1
  def update
    @tweet = current_user.tweets.find(params[:id])
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:user_id, :content)
    end
end
