class CashRegister
    def initialize(discount=0)
        @discount=discount
        @items=[]
        @total=0
    end

    attr_accessor   :discount, :total

    def set_total
        if @items.length>0
            @total=@items.map{|hash| hash['price']*hash['quantity']}.flatten.reduce(0){|acc,num| acc+num}
        else
            @total=0
        end
    end

    def items
        @items.reduce([]){|acc,hash| hash['quantity'].times{acc<<hash['title']}; acc}.flatten
    end

    def add_item(title, price, quantity=1)
        @items<<{'title'=>title, 'price'=>price, 'quantity'=>quantity}
        self.set_total
    end

    def apply_discount
        if self.discount==0
            'There is no discount to apply.'
        else
            @total=self.set_total*(100-self.discount)/100
            "After the discount, the total comes to $#{@total}."
        end
    end

    def void_last_transaction
        @items=self.items.pop(1)
        self.set_total
    end
end