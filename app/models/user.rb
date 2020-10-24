class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable

  
  has_many :banks
  has_many :transactions
  include PermissionsConcern
  
  validates :name, :second_name, :last_name, :second_surname, :state, :city, length: { maximum: 15, message: " El contenido es muy largo (caracteres minimos 15)" }
  validates :day, length: { maximum: 2, message: " El contenido es muy largo (caracteres minimos 2)" }
  validates :month, length: { maximum: 10, message: " El contenido es muy largo (caracteres minimos 10)" }
  validates :address, length: { maximum: 30, message: " El contenido es muy largo (caracteres minimos 30)" }
  validates :country, :gender, length: { maximum: 9, message: " El contenido es muy largo (caracteres minimos 9)" }
  validates :year, length: { maximum: 4, message: " El contenido es muy largo (caracteres minimos 4)" }
  validates :document, uniqueness: {message: " este documento ya esta registrado"}, presence: {message: " este campo no puede estar vacio"}

  validates :day, :year, numericality: {message: " este campo no es un numero"}, allow_nil: true
  validates :document, numericality: {message: " este campo no es un numero"}
end