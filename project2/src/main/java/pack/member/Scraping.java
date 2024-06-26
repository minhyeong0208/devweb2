package pack.member;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.List;

public class Scraping {

    // Jsoup 사용해서 K리그 순위 가져오기
    public List<TeamDto> scrapeRank(){
        List<TeamDto> teamDatalist = new ArrayList<>();
        try {

        	 // K리그 순위 가져오기
            Document doc = Jsoup.connect("https://sports.news.naver.com/kfootball/record/index")
            				.userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36")
            				.get();

            
            // select 이용해서 tr들 불러오기
            Elements footballTeams = doc.select("#regularGroup_table > tr");

            for (Element footballTeam : footballTeams) {
            	 Element rank = footballTeam.selectFirst("th");
                 Element title = footballTeam.selectFirst("span:nth-child(2)"); // 수정하기
                 Element match = footballTeam.selectFirst("td:nth-child(3)"); // 경기 수
                 Element victoryPoint = footballTeam.selectFirst("td:nth-child(4)"); // 승점
                 Element victory = footballTeam.selectFirst("td:nth-child(5)"); // 승수
                 Element draw = footballTeam.selectFirst("td:nth-child(6)"); // 무승부수
                 Element defeat = footballTeam.selectFirst("td:nth-child(7)"); // 패수
                 Element goals = footballTeam.selectFirst("td:nth-child(8)"); // 득점
                 Element loss = footballTeam.selectFirst("td:nth-child(9)"); // 실점

                if(title != null){
                    TeamDto teamData = new TeamDto(rank.text(), title.text(), match.text(), victoryPoint.text(),
                                            victory.text(), draw.text(), defeat.text(), goals.text(), loss.text());
                    teamDatalist.add(teamData);
                }
           }

        } catch (Exception e){
            e.printStackTrace();
        }
        return teamDatalist;
    }

}


