module Faker 

    @gps = [
        "Grande Prêmio da Austrália", "Grande Prêmio do Bahrein", "Grande Prêmio da China", "Grande Prêmio do Azerbaijão", "Grande Prêmio da Espanha", "Grande Prêmio de Mônaco", "Grande Prêmio do Canadá", "Grande Prêmio da França", "Grande Prêmio da Áustria", "Grande Prêmio da Grã-Bretanha", "Grande Prêmio da Alemanha", "Grande Prêmio da Hungria", "Grande Prêmio da Bélgica", "Grande Prêmio da Itália", "Grande Prêmio de Singapura", "Grande Prêmio da Rússia", "Grande Prêmio do Japão", "Grande Prêmio dos Estados Unidos", "Grande Prêmio do México", "Grande Prêmio do Brasil", "Grande Prêmio de Abu Dhabi"]
    

    def self.grandprix
        return @gps[Random.new.rand(0..@gps.length() -1)]
    end
end