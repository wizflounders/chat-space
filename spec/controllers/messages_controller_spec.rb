require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) {create(:user)}

    describe 'GET #index' do
      before do
        login_user user
      end

      it "renders the :index template" do
        get :index, params: { group_id: user.groups.first.id }
        expect(response).to render_template :index
      end

      it "populates an array of @groups" do
        groups_list = create_list(:group, 3)
        groups_list.each do |group|
          create(:group_user, user: user, group: group)
        end
        groups = user.groups
        get :index, params: { group_id: user.groups.first.id }
        expect(assigns(:groups)).to match(groups)
      end

      it "assigns the requested group to @group" do
        group = user.groups.first
        get :index, params: { group_id: user.groups.first.id }
        expect(assigns(:group)).to match(group)
      end

      it "assigns a new item as @message" do
        get :index, params: { group_id: user.groups.first.id }
        expect(assigns(:message)).to be_a_new(Message)
      end

#test失敗することがある。。。created_at不一致 →created_at: 1.day.ago.to_s追加
      it "populates an array of @messages" do
        create_list(:message, 2, user_id: user.id, group_id: user.groups.first.id, created_at: 1.day.ago.to_s )
        get :index, params: { group_id: user.groups.first.id }
        messages = user.groups.first.messages
        expect(assigns(:messages)).to match(messages)
      end
    end

   describe 'GET #index' do
    it "renders the devise/sessions :new template without log_in" do
      get :index, params: { group_id: user.groups.first.id }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST #create' do
    before do
      login_user user
    end
    context 'with valid attributes' do

      it "assigns a new message as @message" do
        post :create,  group_id: user.groups.first.id, message: attributes_for(:message)
         expect(assigns(:message)).to be_a(Message)
         expect(assigns(:message)).to be_persisted
      end

      it "saves the new message in the database" do
        expect{
          post :create, group_id: user.groups.first.id, message: attributes_for(:message)
        }.to change(Message, :count).by(1)
      end

       it "redirects to messages#index" do
         post :create, group_id: user.groups.first.id, message: attributes_for(:message)
         expect(response).to redirect_to group_messages_path
       end
    end

    context 'with invalid attributes without body and message'do

      it "assigns a new message as @message but not registered" do
         post :create,  group_id: user.groups.first.id, message: attributes_for(:message, body:nil, image: nil, group_id: user.groups.first.id, user_id: user.id)
         expect(assigns(:message)).to be_a_new(Message)
         expect(assigns(:message)).not_to be_persisted
      end
      it 'does not save the new message in the database' do
        expect {
           post :create, group_id: user.groups.first.id,  message: attributes_for(:message, body:nil, image: nil, group_id: user.groups.first.id, user_id: user.id)
        }.not_to change(Message, :count)
      end

      it "renders the :index template" do
        post :create, group_id: user.groups.first.id,  message: attributes_for(:message, body:nil, image: nil, group_id: user.groups.first.id, user_id: user.id)
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #index' do
    it "renders the devise/sessions :new template without log_in" do
      get :index, params: { group_id: user.groups.first.id }
      expect(response).to redirect_to new_user_session_path
   end
 end
end
