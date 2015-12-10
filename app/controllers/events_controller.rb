 class EventsController < ApplicationController



    before_action :set_event, :only =>[:SHOW, :update, :edit, :destroy]

 #  GET/events/index
 #  GET/events       當瀏覽器進到兩種，則進到index的action
   def index
    @events =Event.page(params[:page]).per(10)
    # 將資料庫所有資料列出來 (all) 或分頁10筆
    # 所有＠的物件變數都會傳到template的樣版上使用
    # 設定完動作完後，到同名的 index.html.erb設定頁面
   end

   # 瀏覽器跑到get /events/new時對跑到這裡來，執行new的動作，
   # 然後回傳 同名為 new的 相關 html 頁面
   def new
      @event = Event.new

      # 執行：初始化一個空的event
      #      但是執行後要把資料傳到資料庫
             # 必須要在view的event裡建立一個new的樣版進去
             # 呈現給使用者
   end

#   post /events/creat
   def create

      @event = Event.new( event_params )
      # 此處基於網路安全，需另外設定require, permit將hash
      # 過濾出params[:event][:name]和[:event][:description]
      # 此機制稱為： strong parameter

     if @event.save
      flash[:notice] = "新增成功"
        redirect_to :action => :index
        # 輸入表單資料後必須要儲存進資料庫
        # 當輸入資料錯誤時：
        # 告訴瀏覽器http code:303，不希望讓使用者重新整理後又重新送一次表單

    else render :action => :new    # new.html..erb
        # 當輸入沒填滿則顯示警告視窗
      end

   end

   def SHOW
       # @event = Event.find(params[:id])
       # show出每個id的events，設定後再安插view的樣版，及html.erb
   end


    #  get /events/edit/:id
   def edit
       # @event = Event.find(params[:id])

   end

   # post /events/edit/:id
   def update
     # @event = Event.find(params[:id])

     if@event.update(event_params)

      flash[:notice] = "編輯成功"

      redirect_to :action => :SHOW, :id => @event
    else
      render :action => :edit    # edit.html.erb
       #不會重新跳頁，所更新的東西不會消失
   end
 end


   def destroy
      # @event = Event.find(params[:id])

      @event.destroy

      flash[:alert] = "刪除成功"

      redirect_to :action => :index
   end

   private

  def set_event
      @event = Event.find(params[:id])
      # before_action語法 (DRY)
  end

   def event_params
    params.require(:event).permit(:name, :description)
    # 不允許使用者修改除了名字與描述之外的單位

   end
 end

