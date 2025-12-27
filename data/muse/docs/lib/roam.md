--:! {roam: [":"]: ():} <- **Command Line Library for Turtle Movement** -> muse/docs/lib/roam.md      
--:| roam: _Server (turtle) side support for_ `come` _and_ `tail`, _as well as chained_ `go` _commands, motion_ `to` _or_ `trace`. -> roam  

--:: roam.come(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` _from_ `remote.come. -> `":" &:`  

--:: roam.tail(:xyz:) -> _Server side: move turtle (close to) player's GPS_ `xyz` (_from_ `remote.tail)` -> `":" &:`  

--:- to place | x y z face?-> _To named place or position and face. Retry permutation for different first direction._   

--:- trace trailname ->  _Move turtle along traced situations in named trail from one end of trail to the other._  

--:# Movements are `r[ight], l[eft], f[orward], b[ack], u[p], d[own], n[orth], e[ast], s[outh], w[est]`.  

--:- go _(first letter of) directions followed by optional counts, e.g. `r 10 u east 3 u 4 d n`._ -> _Chained movement._  

--:: roam.op(arguments: ":"[]) -> _Move turtle:_ -> `":" &:`  