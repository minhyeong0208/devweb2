package pack.member;

public class TeamDto {
    public String rank, title, match, victoryPoint, victory, draw, defeat, goals, loss;

    public TeamDto(String rank, String title, String match, String victoryPoint,
                   String victory, String draw, String defeat, String goals, String loss){
        this.rank = rank;
        this.title = title;
        this.match = match;
        this.victoryPoint = victoryPoint;
        this.victory = victory;
        this.draw = draw;
        this.defeat = defeat;
        this.goals = goals;
        this.loss = loss;

    }
}
