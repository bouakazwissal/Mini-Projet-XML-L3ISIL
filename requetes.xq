(: Q1: Liste des membres avec le nom de leur catégorie :)
<membres_par_categorie>
{
  for $m in //membre
  let $cat := //categorie[@id = $m/@categorieRef]
  return 
    <membre id="{$m/@id}">
      <nomComplet>{concat($m/prenom, ' ', $m/nom)}</nomComplet>
      <specialite>{$cat/@libelle/string()}</specialite>
    </membre>
}
</membres_par_categorie>,

(: Q2: Liste des concours triés par date :)
<concours_chronologique>
{
  for $c in //concours/concours
  order by xs:date($c/@date) ascending
  return 
    <concours id="{$c/@id}" date="{$c/@date}">
      <titre>{$c/titre/text()}</titre>
    </concours>
}
</concours_chronologique>,

(: Q3: Calcul des scores pour chaque participant :)
<resultats_scores>
{
  for $c in //concours/concours
  for $p in $c//participant
  let $m := //membre[@id = $p/@membreRef]
  let $score := ($p/complexite + $p/tempsExecution) * $c/@coefficient
  return
    <resultat>
      <concours_titre>{$c/titre/text()}</concours_titre>
      <participant>{concat($m/prenom, ' ', $m/nom)}</participant>
      <score_final>{round($score, 2)}</score_final>
    </resultat>
}
</resultats_scores>,

(: Q4: Le vainqueur de chaque concours :)
<vainqueurs>
{
  for $c in //concours/concours
  let $scores := for $p in $c//participant 
                 return ($p/complexite + $p/tempsExecution) * $c/@coefficient
  let $maxScore := max($scores)
  return
    <vainqueur_concours id="{$c/@id}">
      <titre>{$c/titre/text()}</titre>
      {
        for $p in $c//participant
        let $m := //membre[@id = $p/@membreRef]
        let $s := ($p/complexite + $p/tempsExecution) * $c/@coefficient
        where $s = $maxScore
        return
          <gagnant score="{$s}">{concat($m/prenom, ' ', $m/nom)}</gagnant>
      }
    </vainqueur_concours>
}
</vainqueurs>,

(: Q5: Membres d'une catégorie spécifique triés par nom :)
let $categorie := "C1"  (: هنا يمكنك تغيير القيمة بسهولة :)
return
  <membres_C1>
  {
    for $m in //membre[@categorieRef = $categorie]
    order by $m/nom
    return $m
  }
  </membres_C1>