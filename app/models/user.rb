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
    if termino.to_i > 0
      unless termino.to_i % 2 === 0
        id = 0
      else
        id = termino.to_i / 4
      end
  
      User.where(id: id)

    elsif termino.downcase === "completo" || termino.downcase === "incompleto"
      if termino.downcase === "completo"
        User.where.not(status_referencia: "indefinido")
      else
        User.where(status_referencia: "indefinido")
      end
    else
      users = User.all
      array_ids_users = []

      users.each do |user|
        nombres = "#{user.name} #{user.second_name} #{user.last_name} #{user.second_surname}"
        nombres.downcase!
        
        array_termino = termino.split(" ")
        find_termino = true
        array_termino.each do |sub_termino|
          unless nombres.include?(sub_termino.downcase)  
            find_termino = false
          end
        end

        if find_termino
          array_ids_users.push(user.id)
        end
      end

      User.where(id: array_ids_users)
    end

  end
  
  validates :name, :last_name, length: { maximum: 15, message: " El contenido es muy largo (caracteres minimos 15)" }

  validates :day, length: { maximum: 2, message: " El contenido es muy largo (caracteres minimos 2)" }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :month, length: { maximum: 10, message: " El contenido es muy largo (caracteres minimos 10)" }, presence: {message: " este campo no puede estar vacio", on: :update}, format: { with: /\A[a-zA-Z]+\z/, message: " Este campo no puede estar vacio y solo acepta letras", on: :update }

  validates :year, length: { maximum: 4, message: " El contenido es muy largo (caracteres minimos 4)" }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :state, :city, length: { maximum: 30, message: " El contenido es muy largo (caracteres minimos 30)", on: :update }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :address, length: { maximum: 100, message: " El contenido es muy largo (caracteres minimos 100)", on: :update }, presence: {message: " este campo no puede estar vacio", on: :update} 

  validates :country, :gender, length: { maximum: 9, message: " El contenido es muy largo (caracteres minimos 9)" }, presence: {message: " este campo no puede estar vacio", on: :update}, format: { with: /\A[a-zA-Z]+\z/, message: " Este campo no puede estar vacio y solo acepta letras", on: :update }

  validates :document, uniqueness: {message: " este documento ya esta registrado", on: :update}, presence: {message: " este campo no puede estar vacio", on: :update}, length: { in: 5..14, message: " El numero de digitos permitidos es minimo 5 y maximo 14", on: :update }

  validates :phone, uniqueness: {message: " este telefono ya esta registrado", on: :update}, presence: {message: " este campo no puede estar vacio", on: :update}, length: { in: 10..12, message: " El numero de digitos permitidos es minimo 10 y maximo 12", on: :update }

  validates :day, :year, :document, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números", on: :update}

  #validates :num_referidor, format: {with: /\A[+-]?\d+\z/, message: " El numero de usuario que ingreso no pertenece a ninguno de los usuarios existentes", on: :update}, length: { maximum: 9, message: " El campo debe contener 9 números", on: :update }
end