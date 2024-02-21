%% convolution_ex3.m
%
% This script demonstrates the convolution of two sequences x(n) and
% h(n) to obtain the output sequence y(n).

close all; clear; clc;

addpath("tools")

x = [3, 11, 7, 0, -1, 4, 2];
nx = -3: 3;

h = [2, 3, 0, -5, 2, 1];
nh = -1: 4;

[y,ny] = conv_m(x,nx,h,nh)
