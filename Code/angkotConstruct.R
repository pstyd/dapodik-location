##the project is to capture the real activity of angkot
##we would like to simulate the income distribution of angkot

#the purpose of this project is training
#at the same time tries to capture the randomness of angkot as public transportation

#modelling the angkot based on matrix with time series
#row will be the representation of seats in angkot
#column will be the representation of observed time/angkot stop

#in every observed time, each seat has value: 0,1,2,3,4, and 7
#0 represents empty seat
#1 represents the 2000 rupiah worth of travel
#2 represents the 2500 rupiah worth of travel
#3 represents the 3000 rupiah worth of travel
#4 represents the 3500 rupiah worth of travel
#7 represents the 2000 rupiah worth of travel for student

#each seat will be evaluated at observed time
#if there is a changes in seat value, it means the driver collects money 
#from the previous passenger
#at the final stop, driver will collect money from every passengers left in his vechile

#---------------------------------------------------------------------------------------#

angkotCons <- function(seats, stops) {
  angkotMat <- matrix(round(runif(seats,0,1),0),nrow=seats,ncol=stops)
}