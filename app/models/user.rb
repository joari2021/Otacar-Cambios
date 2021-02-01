class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :trackable and :omniauthable :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :banks
  has_many :bank_brasils
  has_many :wallets
  has_many :wallet_with_users
  has_many :digital_payments
  has_many :mobile_payments
  has_many :transactions
  has_many :notifications

  include PermissionsConcern

  def self.buscador(termino)
    unless termino.to_i % 2 === 0
      id = ""
    else
      id = termino.to_i / 4
    end

    User.where(id: id)

    #User.where("id LIKE ?", "%#{id}%")
  end
  
  validates :name, :last_name, length: { maximum: 15, message: " El contenido es muy largo (caracteres minimos 15)" }, format: { with: /\A[a-zA-Z]+\z/, message: " Este campo no puede estar vacio y solo acepta letras", on: :update }

  validates :day, length: { maximum: 2, message: " El contenido es muy largo (caracteres minimos 2)" }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :month, length: { maximum: 10, message: " El contenido es muy largo (caracteres minimos 10)" }, presence: {message: " este campo no puede estar vacio", on: :update}, format: { with: /\A[a-zA-Z]+\z/, message: " Este campo no puede estar vacio y solo acepta letras", on: :update }

  validates :year, length: { maximum: 4, message: " El contenido es muy largo (caracteres minimos 4)" }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :state, :city, length: { maximum: 30, message: " El contenido es muy largo (caracteres minimos 30)", on: :update }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :address, length: { maximum: 100, message: " El contenido es muy largo (caracteres minimos 100)", on: :update }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :country, :gender, length: { maximum: 9, message: " El contenido es muy largo (caracteres minimos 9)" }, presence: {message: " este campo no puede estar vacio", on: :update}, format: { with: /\A[a-zA-Z]+\z/, message: " Este campo no puede estar vacio y solo acepta letras", on: :update }

  validates :document, uniqueness: {message: " este documento ya esta registrado", on: :update}, presence: {message: " este campo no puede estar vacio", on: :update}, length: { in: 5..12, message: " El numero de digitos permitidos es minimo 5 y maximo 12", on: :update }

  validates :phone, uniqueness: {message: " este telefono ya esta registrado", on: :update}, presence: {message: " este campo no puede estar vacio", on: :update}, length: { in: 10..12, message: " El numero de digitos permitidos es minimo 10 y maximo 12", on: :update }

  validates :day, :year, :document, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números", on: :update}

  #validates :num_referidor, format: {with: /\A[+-]?\d+\z/, message: " El numero de usuario que ingreso no pertenece a ninguno de los usuarios existentes", on: :update}, length: { maximum: 9, message: " El campo debe contener 9 números", on: :update }
end